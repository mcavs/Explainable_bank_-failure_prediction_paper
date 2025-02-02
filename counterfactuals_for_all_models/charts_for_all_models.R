# combining all the datasets
combined_datasets <- bind_rows(
  org_summary_metrics %>% mutate(Model = "Original"),
  undersamp_summary_metrics %>% mutate(Model = "Undersampling"),
  oversamp_summary_metrics %>% mutate(Model = "Oversampling"),
  smote_summary_metrics %>% mutate(Model = "SMOTE"),
  summary_metrics %>% mutate(Model = "Cost-sensitive")
) %>% mutate(Model = factor(
  Model,
  levels = c(
    "Original",
    "Undersampling",
    "Oversampling",
    "SMOTE",
    "Cost-sensitive"
  )
))

# making graph including all CE methods, metrics and models
ggplot(
  combined_datasets,
  aes(
    x = CE_Method,
    y = Mean_Values,
    color = Used_Model,
    group = Used_Model
  )
) +
  geom_line(position = position_dodge(width = 0.5),
            size = 1.5,
            alpha = 0.7) +
  geom_point(position = position_dodge(width = 0.5),
             size = 3.5,
             alpha = 0.7) +
  geom_errorbar(
    aes(
      ymin = Mean_Values - StdDev_Values,
      ymax = Mean_Values + StdDev_Values
    ),
    width = 0.5,
    size = 1.5,
    alpha = 0.7,
    position = position_dodge(width = 0.5)
  ) +
  facet_grid(Quality_Metric ~ Model, scales = "free_y") +
  labs(x = "", y = "", color = "Used Model") +
  theme_minimal() +
  theme(legend.position = "bottom") +
  theme(legend.title = element_blank()) +
  theme(
    axis.text.y = element_text(size = 25),
    axis.text.x = element_text(size = 25),
    strip.text = element_text(size = 25),
    strip.text.y = element_text(angle = 0),
    legend.text = element_text(size = 25),
    axis.title.y = element_text(size = 25)
  )
