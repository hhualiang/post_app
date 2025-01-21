abstract class Mapper<DTO, Entity> {
  Entity toEntity(DTO dto);
}
